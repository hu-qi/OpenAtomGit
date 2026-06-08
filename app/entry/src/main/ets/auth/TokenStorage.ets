import preferences from '@ohos.data.preferences';
import common from '@ohos.app.ability.common';

export class TokenStorage {
  private static readonly STORE_NAME: string = 'open_atom_git_auth';
  private static readonly TOKEN_KEY: string = 'token';

  static async saveToken(context: common.UIAbilityContext, token: string): Promise<void> {
    const store = await preferences.getPreferences(context, TokenStorage.STORE_NAME);
    await store.put(TokenStorage.TOKEN_KEY, token);
    await store.flush();
  }

  static async getToken(context: common.UIAbilityContext): Promise<string> {
    const store = await preferences.getPreferences(context, TokenStorage.STORE_NAME);
    const value = await store.get(TokenStorage.TOKEN_KEY, '');
    if (typeof value === 'string') {
      return value;
    }
    return '';
  }

  static async clearToken(context: common.UIAbilityContext): Promise<void> {
    const store = await preferences.getPreferences(context, TokenStorage.STORE_NAME);
    await store.delete(TokenStorage.TOKEN_KEY);
    await store.flush();
  }
}
