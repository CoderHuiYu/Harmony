import router from '@ohos.router'
import { UserModel } from '../../models/UserModel'

// 1. 初始化持久化USER

// 2. 提供设置、获取、删除USER能力

// 3. 提供访问权限控制的跳转api
export const USER_KEY = 'interview-user'
const PASS_LIST = ['pages/LoginPage', 'pages/Index']

export class Auth {
  static initLocalUser() {
    PersistentStorage.PersistProp(USER_KEY, '{}')
  }

  static setUser(user: UserModel) {
    AppStorage.Set(USER_KEY, JSON.stringify(user))
  }

  static getUser(): UserModel {
    const user = AppStorage.Get<string>(USER_KEY) || '{}'
    return JSON.parse(user) as UserModel
  }

  static delUser() {
    AppStorage.Set(USER_KEY, '{}')
  }

  static pushUrl(options: router.RouterOptions): void  {
    // 需要登录的页面 且 没有登录  ====>  跳转登录页面 且 需要把页面的地址和参数传递给登录页面
    const user = Auth.getUser()
    if (!PASS_LIST.includes(options.url) && !user.token) {
      // 去登录
      router.pushUrl({
        url: 'pages/LoginPage',
        params: {
          // ...options.params,
          return_url: options.url
        }
      })

      return
    }
    router.pushUrl(options)
  }
}