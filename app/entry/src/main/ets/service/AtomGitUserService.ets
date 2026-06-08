import { AtomGitHttpClient } from './AtomGitHttpClient';
import { UserDto } from '../dto/UserDto';
import { UserMapper } from '../mapper/UserMapper';
import { UserModel } from '../model/UserModel';

export class AtomGitUserService {
  static async getCurrentUser(token: string): Promise<UserModel | null> {
    const body = await AtomGitHttpClient.get('/user', token);
    if (body.length === 0) {
      return null;
    }

    try {
      const dto = JSON.parse(body) as UserDto;
      return UserMapper.fromDto(dto);
    } catch (error) {
      return null;
    }
  }
}
