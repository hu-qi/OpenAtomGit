import { TokenManager } from '../auth/TokenManager';
import { RepositoryDto } from '../dto/RepositoryDto';
import { RepositoryFileDto } from '../dto/RepositoryFileDto';
import { RepositoryFileMapper } from '../mapper/RepositoryFileMapper';
import { RepositoryMapper } from '../mapper/RepositoryMapper';
import { RepositoryFileModel } from '../model/RepositoryFileModel';
import { RepositoryModel } from '../model/RepositoryModel';
import { AtomGitHttpClient } from './AtomGitHttpClient';

export class AtomGitRepositoryService {
  static async getRepositoryDetail(repository: RepositoryModel): Promise<RepositoryModel | null> {
    const token = TokenManager.getToken();
    if (token.length === 0 || repository.owner.length === 0 || repository.name.length === 0) {
      return null;
    }

    const path = '/repos/' + encodeURIComponent(repository.owner) + '/' + encodeURIComponent(repository.name);
    const body = await AtomGitHttpClient.get(path, token);
    if (body.length === 0) {
      return null;
    }

    try {
      const dto = JSON.parse(body) as RepositoryDto;
      return RepositoryMapper.fromDto(dto);
    } catch (error) {
      return null;
    }
  }

  static async getReadme(repository: RepositoryModel): Promise<string> {
    const token = TokenManager.getToken();
    if (token.length === 0 || repository.owner.length === 0 || repository.name.length === 0) {
      return '';
    }

    const path = '/repos/' + encodeURIComponent(repository.owner) + '/' + encodeURIComponent(repository.name) + '/readme';
    const body = await AtomGitHttpClient.get(path, token);
    if (body.length === 0) {
      return '';
    }

    try {
      const parsed = JSON.parse(body) as Record<string, string>;
      return parsed.content || parsed.html || parsed.text || body;
    } catch (error) {
      return body;
    }
  }

  static async getRootFiles(repository: RepositoryModel): Promise<RepositoryFileModel[]> {
    return await AtomGitRepositoryService.getFiles(repository, '');
  }

  static async getFiles(repository: RepositoryModel, targetPath: string): Promise<RepositoryFileModel[]> {
    const token = TokenManager.getToken();
    if (token.length === 0 || repository.owner.length === 0 || repository.name.length === 0) {
      return [];
    }

    const path = '/repos/' + encodeURIComponent(repository.owner) + '/' + encodeURIComponent(repository.name) + '/contents' + (targetPath.length > 0 ? '/' + encodeURIComponent(targetPath) : '');
    const body = await AtomGitHttpClient.get(path, token);
    if (body.length === 0) {
      return [];
    }

    try {
      const list = JSON.parse(body) as RepositoryFileDto[];
      return RepositoryFileMapper.fromDtoList(list);
    } catch (error) {
      return [];
    }
  }
}
