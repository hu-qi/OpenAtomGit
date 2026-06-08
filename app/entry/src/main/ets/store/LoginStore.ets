import { TokenManager } from '../auth/TokenManager';
import { AtomGitAuthService } from '../service/AtomGitAuthService';

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

    const isValid = await AtomGitAuthService.validateToken(this.token);
    if (!isValid) {
      this.errorMessage = 'Token validation failed';
      this.isLoggedIn = false;
      return false;
    }

    TokenManager.setToken(this.token);
    this.isLoggedIn = true;
    this.errorMessage = '';
    return true;
  }

  logout(): void {
    TokenManager.clear();
    this.token = '';
    this.isLoggedIn = false;
    this.errorMessage = '';
  }
}
