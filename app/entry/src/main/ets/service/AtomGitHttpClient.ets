import http from '@ohos.net.http';
import { AtomGitConfig } from './AtomGitConfig';

export class AtomGitHttpClient {
  static getBaseUrl(): string {
    return AtomGitConfig.API_BASE;
  }

  static buildQuery(params: Record<string, string>): string {
    const pairs: string[] = [];
    Object.keys(params).forEach((key: string) => {
      pairs.push(encodeURIComponent(key) + '=' + encodeURIComponent(params[key]));
    });
    return pairs.length === 0 ? '' : '?' + pairs.join('&');
  }

  static async get(path: string, token: string, params?: Record<string, string>): Promise<string> {
    const httpRequest = http.createHttp();
    const query = params ? AtomGitHttpClient.buildQuery(params) : '';
    const url = AtomGitConfig.API_BASE + path + query;

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

      if (response.responseCode < 200 || response.responseCode >= 300) {
        return '';
      }

      if (typeof response.result === 'string') {
        return response.result;
      }

      return JSON.stringify(response.result);
    } catch (error) {
      return '';
    } finally {
      httpRequest.destroy();
    }
  }
}
