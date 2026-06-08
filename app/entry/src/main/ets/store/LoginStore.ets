import { TokenManager } from '../auth/TokenManager';

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

  loginWithToken(): boolean {
    if (!this.canLogin()) {
      this.errorMessage = 'Token is required';
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
