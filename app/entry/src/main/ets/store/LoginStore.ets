import { TokenManager } from '../auth/TokenManager';
import { SessionManager } from '../auth/SessionManager';
import { AtomGitUserService } from '../service/AtomGitUserService';

export class LoginStore {
  token: string = '';
  isLoggedIn: boolean = false;
  errorMessage: string = '';

  setToken(value: string): void {
    this.token = value.trim();
    this.errorMessage = '';
  }

  canLogin(): boolean {
    return this.token.length > 0;
  }

  async loginWithToken(): Promise<boolean> {
    if (!this.canLogin()) {
      this.errorMessage = 'Token is required';
      this.isLoggedIn = false;
      return false;
    }

    const currentUser = await AtomGitUserService.getCurrentUser(this.token);
    if (currentUser === null) {
      this.errorMessage = 'Token validation failed';
      this.isLoggedIn = false;
      return false;
    }

    TokenManager.setToken(this.token);
    SessionManager.setCurrentUser(currentUser);
    this.isLoggedIn = true;
    this.errorMessage = '';
    return true;
  }

  logout(): void {
    TokenManager.clear();
    SessionManager.clear();
    this.token = '';
    this.isLoggedIn = false;
    this.errorMessage = '';
  }
}
