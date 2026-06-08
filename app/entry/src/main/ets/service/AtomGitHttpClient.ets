import http from '@ohos.net.http';
import { AtomGitConfig } from './AtomGitConfig';

export class AtomGitHttpClient {
  static getBaseUrl(): string {
    return AtomGitConfig.API_BASE;
  }

  static async get(path: string, token: string): Promise<boolean> {
    const httpRequest = http.createHttp();
    const url = AtomGitConfig.API_BASE + path;

    try {
      const response = await httpRequest.request(url, {
        method: http.RequestMethod.GET,
        header: {
          'Authorization': 'Bearer ' + token,
          'Content-Type': 'application/json'
        },
        readTimeout: 10000,
        connectTimeout: 10000
      });

      return response.responseCode >= 200 && response.responseCode < 300;
    } catch (error) {
      return false;
    } finally {
      httpRequest.destroy();
    }
  }
}
