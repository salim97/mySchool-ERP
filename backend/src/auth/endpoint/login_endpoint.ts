import * as express from 'express'
import IAuthRepository from '../domain/IAuthRepository'
import IPasswordService from '../services/IPasswordService'
import ITokenService from '../services/ITokenService'

export default class LoginEndpoint {
  constructor(
    private authRepository: IAuthRepository,
    private passwordService: IPasswordService,
    private tokenService: ITokenService,
  ) {}

  public async request(req: express.Request, res: express.Response) {
    try {
      const { name, email, password, auth_type } = req.body
      return this.execute(name, email, password, auth_type)
        .then((id: string) =>
          res.status(200).json({ auth_token: this.tokenService.encode(id) })
        )
        .catch((err: Error) => {
          console.log(err);
          return res.status(404).json({ error: err, "zebi f zokek": "mkhabi" })
        })
    } catch (err) {
      return res.status(400).json({ error: err })
    }
  }

  public async execute(
    name: string,
    email: string,
    password: string,
    type: string
  ): Promise<string> {
    if (type === 'email') return this.emailLogin(email, password)

    return this.oauthLogin(name, email, type)
  }

  private async emailLogin(email: string, password: string) {
    const user = await this.authRepository.find(email).catch((_) => null)
    if (!user || !(await this.passwordService.compare(password, user.password)))
      return Promise.reject('Invalid email or password')

    return user.id
  }
  private async oauthLogin(name: string, email: string, type: string) {
    const user = await this.authRepository.find(email).catch((_) => null)
    if (user && user.type === 'email')
      return Promise.reject('account already exists, log in with password')
    if (user) return user.id

    const userId = await this.authRepository.add(name, email, type)
    return userId
  }
}
