import common from '@ohos.app.ability.common';
import { TokenStorage } from './TokenStorage';

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

  static async saveToken(context: common.UIAbilityContext, value: string): Promise<void> {
    TokenManager.setToken(value);
    await TokenStorage.saveToken(context, value);
  }

  static async restoreToken(context: common.UIAbilityContext): Promise<string> {
    const value = await TokenStorage.getToken(context);
    TokenManager.setToken(value);
    return value;
  }

  static async clearSavedToken(context: common.UIAbilityContext): Promise<void> {
    TokenManager.clear();
    await TokenStorage.clearToken(context);
  }
}
