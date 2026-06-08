import { AtomGitConfig } from './AtomGitConfig';

export class AtomGitHttpClient {
  static getBaseUrl(): string {
    return AtomGitConfig.API_BASE;
  }
}
