import * as express from 'express'
import IAuthRepository from '../domain/IAuthRepository'
import IPasswordService from '../services/IPasswordService'
import ITokenService from '../services/ITokenService'

export default class SignUpEndpoint {
  constructor(
    private authRespository: IAuthRepository,
    private passwordService: IPasswordService,
    private tokenService: ITokenService,
  ) {}

  public async request(req: express.Request, res: express.Response) {
    try {
      const { name, email, password, auth_type } = req.body
      return this.execute(name, auth_type, email, password)
        .then((id: string) =>
          res.status(200).json({ auth_token: this.tokenService.encode(id) })
        )
        .catch((err: Error) => res.status(404).json({ error: err }))
    } catch (err) {
      return res.status(400).json({ error: err })
    }
  }

  public async execute(
    name: string,
    authType: string,
    email: string,
    password: string
  ): Promise<string> {
    const user = await this.authRespository.find(email).catch((_) => null)
    if (user) return Promise.reject('User already exists')
    let passwordhash
    if (password) {
      passwordhash = await this.passwordService.hash(password)
    } else {
      passwordhash = undefined
    }

    const userId = await this.authRespository.add(
      name,
      email,
      authType,
      passwordhash
    )
    return userId
  }
}
