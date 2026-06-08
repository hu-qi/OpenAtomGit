export class TokenManager {
  private static token: string = '';

  static setToken(value: string): void {
    TokenManager.token = value;
  }

  static getToken(): string {
    return TokenManager.token;
  }

  static clear(): void {
    TokenManager.token = '';
  }
}
