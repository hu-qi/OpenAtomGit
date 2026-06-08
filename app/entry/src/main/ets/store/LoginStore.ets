import { TokenManager } from '../auth/TokenManager';

export class LoginStore {
  token: string = '';
  isLoggedIn: boolean = false;

  setToken(value: string): void {
    this.token = value;
  }

  loginWithToken(): void {
    TokenManager.setToken(this.token);
    this.isLoggedIn = this.token.length > 0;
  }

  logout(): void {
    TokenManager.clear();
    this.token = '';
    this.isLoggedIn = false;
  }
}
