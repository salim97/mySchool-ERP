import * as express from 'express'
import ITokenStore from '../services/ITokenStore'

export default class SignOutEndpoint {
  constructor(private readonly tokenStore: ITokenStore) {}


  public async request(req: express.Request, res: express.Response) {
    try {
      const token = req.headers.authorization!
      return this.execute(token)
        .then((result) => res.status(200).json({ message: result }))
        .catch((err: Error) => res.status(404).json({ error: err }))
    } catch (err) {
      return res.status(400).json({ error: err })
    }
  }

  public async execute(token: string): Promise<string> {
    this.tokenStore.save(token)
    return Promise.resolve('Successfully signed out')
  }
}
