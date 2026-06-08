import { AtomGitUserService } from './AtomGitUserService';

export class AtomGitAuthService {
  static async validateToken(token: string): Promise<boolean> {
    if (token.trim().length === 0) {
      return false;
    }

    const currentUser = await AtomGitUserService.getCurrentUser(token);
    return currentUser !== null;
  }
}
