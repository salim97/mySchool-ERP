import * as express from 'express'
import IAuthRepository from './auth/domain/IAuthRepository'
import TokenValidator from './auth/helpers/TokenValidator'
import {
  signinValidationRules,
  signupValidationRules,
} from './auth/helpers/Validators'
import IPasswordService from './auth/services/IPasswordService'
import ITokenService from './auth/services/ITokenService'
import ITokenStore from './auth/services/ITokenStore'
import LoginEndpoint from './auth/endpoint/login_endpoint'
import SignOutEndpoint from './auth/endpoint/sign_out_endpoint'
import SignUpEndpoint from './auth/endpoint/sign_up_endpoint'
import { validate } from './auth/helpers/Validators'
import FirebaseNotificationEndpoint from './auth/endpoint/FirebaseNotificationUseCase'

export default class AuthRouter {
  public static configure(
    authRepository: IAuthRepository,
    tokenService: ITokenService,
    tokenStore: ITokenStore,
    passwordService: IPasswordService,
    tokenValidator: TokenValidator
  ): express.Router {
    const router = express.Router()
    const signinEndpoint = new LoginEndpoint(authRepository, passwordService, tokenService)
    const signupEndpoint = new SignUpEndpoint(authRepository, passwordService, tokenService)
    const signoutEndpoint = new SignOutEndpoint(tokenStore)
    const firebaseNotificationEndpoint = new FirebaseNotificationEndpoint(authRepository)

    // let controller = AuthRouter.composeController(
    //   authRepository,
    //   tokenService,
    //   tokenStore,
    //   passwordService
    // )
    router.post(
      '/signin',
      signinValidationRules(),
      validate,
      (req: express.Request, res: express.Response) =>
      signinEndpoint.request(req, res)
    )
    router.post(
      '/signup',
      signupValidationRules(),
      validate,
      (req: express.Request, res: express.Response) =>
      signupEndpoint.request(req, res)
    )

    router.post(
      '/signout',
      (req, res, next) => tokenValidator.validate(req, res, next),
      (req: express.Request, res: express.Response) =>
      signoutEndpoint.request(req, res)
    )

    router.post(
      '/notify',
      // signupValidationRules(), // request body json check
      // (req, res, next) => tokenValidator.validate(req, res, next),
      (req: express.Request, res: express.Response) =>
      firebaseNotificationEndpoint.request(req, res)
    )


    return router
  }

  // private static composeController(
  //   authRepository: IAuthRepository,
  //   tokenService: ITokenService,
  //   tokenStore: ITokenStore,
  //   passwordService: IPasswordService
  // ): AuthController {
  //   const signinUseCase = new SignInUseCase(authRepository, passwordService, tokenService)
  //   const signupUseCase = new SignUpUseCase(authRepository, passwordService)
  //   const signoutUseCase = new SignOutUseCase(tokenStore)
  //   // const notificationUseCase = new NotificationUseCase(authRepository);
  //   const controller = new AuthController(
  //     signinUseCase,
  //     signupUseCase,
  //     signoutUseCase,
  //     tokenService
  //   )
  //   return controller
  // }
}
