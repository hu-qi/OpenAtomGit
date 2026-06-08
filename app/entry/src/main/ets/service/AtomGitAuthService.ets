import { AtomGitHttpClient } from './AtomGitHttpClient';

export class AtomGitAuthService {
  static async validateToken(token: string): Promise<boolean> {
    if (token.trim().length === 0) {
      return false;
    }

    return await AtomGitHttpClient.get('/user', token);
  }
}
