import { UserDto } from '../dto/UserDto';
import { UserModel } from '../model/UserModel';

export class UserMapper {
  static fromDto(dto: UserDto): UserModel {
    const username = dto.login || dto.username || '';
    const nickname = dto.name || dto.nickname || username;
    const avatarUrl = dto.avatar_url || dto.avatarUrl || '';
    return new UserModel(username, nickname, avatarUrl);
  }
}
