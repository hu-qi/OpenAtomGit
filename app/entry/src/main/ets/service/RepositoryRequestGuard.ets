import { RepositoryModel } from '../model/RepositoryModel';

export class RepositoryRequestGuard {
  static hasToken(token: string): boolean {
    return token.length > 0;
  }

  static hasRepository(repository: RepositoryModel): boolean {
    return repository.owner.length > 0 && repository.name.length > 0;
  }

  static canRequestRepository(token: string, repository: RepositoryModel): boolean {
    return RepositoryRequestGuard.hasToken(token) && RepositoryRequestGuard.hasRepository(repository);
  }

  static hasIssueNumber(issueNumber: number): boolean {
    return issueNumber > 0;
  }

  static canRequestIssue(token: string, repository: RepositoryModel, issueNumber: number): boolean {
    return RepositoryRequestGuard.canRequestRepository(token, repository) && RepositoryRequestGuard.hasIssueNumber(issueNumber);
  }

  static canRequestFile(token: string, repository: RepositoryModel, filePath: string): boolean {
    return RepositoryRequestGuard.canRequestRepository(token, repository) && filePath.length > 0;
  }
}
