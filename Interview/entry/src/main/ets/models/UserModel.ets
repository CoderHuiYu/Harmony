export class UserModel {
  id: string
  username: string
  avatar: string
  token: string
  refreshToken: string
  nickName?: string
  totalTime?: number
  clockinNumbers?: number

  constructor(id: string, username: string, avatar: string, token: string, refreshToken: string) {
    this.id = id
    this.username = username
    this.avatar = avatar
    this.token = token
    this.refreshToken = refreshToken
  }

}