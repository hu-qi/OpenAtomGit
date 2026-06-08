import { TokenManager } from '../auth/TokenManager';
import { IssueDto } from '../dto/IssueDto';
import { IssueMapper } from '../mapper/IssueMapper';
import { IssueModel } from '../model/IssueModel';
import { RepositoryModel } from '../model/RepositoryModel';
import { AtomGitHttpClient } from './AtomGitHttpClient';

export class AtomGitIssueService {
  static async getOpenIssues(repository: RepositoryModel): Promise<IssueModel[]> {
    const token = TokenManager.getToken();
    if (token.length === 0 || repository.owner.length === 0 || repository.name.length === 0) {
      return [];
    }

    const path = '/repos/' + encodeURIComponent(repository.owner) + '/' + encodeURIComponent(repository.name) + '/issues';
    const body = await AtomGitHttpClient.get(path, token, {
      state: 'open',
      page: '1',
      per_page: '20'
    });

    if (body.length === 0) {
      return [];
    }

    try {
      const list = JSON.parse(body) as IssueDto[];
      return IssueMapper.fromDtoList(list);
    } catch (error) {
      return [];
    }
  }
}
