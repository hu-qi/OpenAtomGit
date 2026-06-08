import { TokenManager } from '../auth/TokenManager';
import { IssueCommentDto } from '../dto/IssueCommentDto';
import { IssueDto } from '../dto/IssueDto';
import { IssueCommentMapper } from '../mapper/IssueCommentMapper';
import { IssueMapper } from '../mapper/IssueMapper';
import { IssueCommentModel } from '../model/IssueCommentModel';
import { IssueModel } from '../model/IssueModel';
import { RepositoryModel } from '../model/RepositoryModel';
import { AtomGitHttpClient } from './AtomGitHttpClient';
import { RepositoryPathHelper } from './RepositoryPathHelper';

export class AtomGitIssueService {
  static async getOpenIssues(repository: RepositoryModel): Promise<IssueModel[]> {
    const token = TokenManager.getToken();
    if (token.length === 0 || repository.owner.length === 0 || repository.name.length === 0) {
      return [];
    }

    const path = RepositoryPathHelper.issuesPath(repository.owner, repository.name);
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

  static async getIssueDetail(repository: RepositoryModel, issueNumber: number): Promise<IssueModel | null> {
    const token = TokenManager.getToken();
    if (token.length === 0 || repository.owner.length === 0 || repository.name.length === 0 || issueNumber <= 0) {
      return null;
    }

    const path = RepositoryPathHelper.issueDetailPath(repository.owner, repository.name, issueNumber);
    const body = await AtomGitHttpClient.get(path, token);
    if (body.length === 0) {
      return null;
    }

    try {
      const dto = JSON.parse(body) as IssueDto;
      return IssueMapper.fromDto(dto);
    } catch (error) {
      return null;
    }
  }

  static async getIssueComments(repository: RepositoryModel, issueNumber: number): Promise<IssueCommentModel[]> {
    const token = TokenManager.getToken();
    if (token.length === 0 || repository.owner.length === 0 || repository.name.length === 0 || issueNumber <= 0) {
      return [];
    }

    const path = RepositoryPathHelper.issueCommentsPath(repository.owner, repository.name, issueNumber);
    const body = await AtomGitHttpClient.get(path, token, {
      page: '1',
      per_page: '20'
    });

    if (body.length === 0) {
      return [];
    }

    try {
      const list = JSON.parse(body) as IssueCommentDto[];
      return IssueCommentMapper.fromDtoList(list);
    } catch (error) {
      return [];
    }
  }
}
