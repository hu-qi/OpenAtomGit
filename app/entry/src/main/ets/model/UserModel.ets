export class UserModel {
  username: string = '';
  nickname: string = '';
  avatarUrl: string = '';

  constructor(username: string, nickname: string, avatarUrl: string) {
    this.username = username;
    this.nickname = nickname;
    this.avatarUrl = avatarUrl;
  }
}
