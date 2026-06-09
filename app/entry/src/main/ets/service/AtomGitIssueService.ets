import { TokenManager } from '../auth/TokenManager';
import { IssueCommentDto } from '../dto/IssueCommentDto';
import { IssueDto } from '../dto/IssueDto';
import { IssueCommentMapper } from '../mapper/IssueCommentMapper';
import { IssueMapper } from '../mapper/IssueMapper';
import { IssueCommentModel } from '../model/IssueCommentModel';
import { IssueModel } from '../model/IssueModel';
import { RepositoryModel } from '../model/RepositoryModel';
import { AtomGitHttpClient } from './AtomGitHttpClient';
import { JsonParseHelper } from './JsonParseHelper';
import { RepositoryPathHelper } from './RepositoryPathHelper';
import { RepositoryRequestGuard } from './RepositoryRequestGuard';

export class AtomGitIssueService {
  static async getOpenIssues(repository: RepositoryModel): Promise<IssueModel[]> {
    const token = TokenManager.getToken();
    if (!RepositoryRequestGuard.canRequestRepository(token, repository)) {
      return [];
    }

    const path = RepositoryPathHelper.issuesPath(repository.owner, repository.name);
    const body = await AtomGitHttpClient.get(path, token, {
      state: 'open',
      page: '1',
      per_page: '20'
    });

    const list = JsonParseHelper.parseArray<IssueDto>(body);
    return IssueMapper.fromDtoList(list);
  }

  static async getIssueDetail(repository: RepositoryModel, issueNumber: number): Promise<IssueModel | null> {
    const token = TokenManager.getToken();
    if (!RepositoryRequestGuard.canRequestIssue(token, repository, issueNumber)) {
      return null;
    }

    const path = RepositoryPathHelper.issueDetailPath(repository.owner, repository.name, issueNumber);
    const body = await AtomGitHttpClient.get(path, token);
    const dto = JsonParseHelper.parseObject<IssueDto>(body);
    if (dto === null) {
      return null;
    }

    return IssueMapper.fromDto(dto);
  }

  static async getIssueComments(repository: RepositoryModel, issueNumber: number): Promise<IssueCommentModel[]> {
    const token = TokenManager.getToken();
    if (!RepositoryRequestGuard.canRequestIssue(token, repository, issueNumber)) {
      return [];
    }

    const path = RepositoryPathHelper.issueCommentsPath(repository.owner, repository.name, issueNumber);
    const body = await AtomGitHttpClient.get(path, token, {
      page: '1',
      per_page: '20'
    });

    const list = JsonParseHelper.parseArray<IssueCommentDto>(body);
    return IssueCommentMapper.fromDtoList(list);
  }
}
