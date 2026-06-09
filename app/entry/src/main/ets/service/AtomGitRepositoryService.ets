import { TokenManager } from '../auth/TokenManager';
import { RepositoryDto } from '../dto/RepositoryDto';
import { RepositoryFileContentDto } from '../dto/RepositoryFileContentDto';
import { RepositoryFileDto } from '../dto/RepositoryFileDto';
import { RepositoryReadmeDto } from '../dto/RepositoryReadmeDto';
import { RepositoryFileMapper } from '../mapper/RepositoryFileMapper';
import { RepositoryMapper } from '../mapper/RepositoryMapper';
import { RepositoryFileModel } from '../model/RepositoryFileModel';
import { RepositoryModel } from '../model/RepositoryModel';
import { AtomGitHttpClient } from './AtomGitHttpClient';
import { RepositoryPathHelper } from './RepositoryPathHelper';
import { RepositoryRequestGuard } from './RepositoryRequestGuard';

export class AtomGitRepositoryService {
  static async getRepositoryDetail(repository: RepositoryModel): Promise<RepositoryModel | null> {
    const token = TokenManager.getToken();
    if (!RepositoryRequestGuard.canRequestRepository(token, repository)) {
      return null;
    }

    const path = RepositoryPathHelper.repositoryPath(repository.owner, repository.name);
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
    if (!RepositoryRequestGuard.canRequestRepository(token, repository)) {
      return '';
    }

    const path = RepositoryPathHelper.readmePath(repository.owner, repository.name);
    const body = await AtomGitHttpClient.get(path, token);
    if (body.length === 0) {
      return '';
    }

    try {
      const parsed = JSON.parse(body) as RepositoryReadmeDto;
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
    if (!RepositoryRequestGuard.canRequestRepository(token, repository)) {
      return [];
    }

    const path = RepositoryPathHelper.contentsPath(repository.owner, repository.name, targetPath);
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

  static async getFileContent(repository: RepositoryModel, filePath: string): Promise<string> {
    const token = TokenManager.getToken();
    if (!RepositoryRequestGuard.canRequestFile(token, repository, filePath)) {
      return '';
    }

    const path = RepositoryPathHelper.contentsPath(repository.owner, repository.name, filePath);
    const body = await AtomGitHttpClient.get(path, token);
    if (body.length === 0) {
      return '';
    }

    try {
      const parsed = JSON.parse(body) as RepositoryFileContentDto;
      return parsed.content || body;
    } catch (error) {
      return body;
    }
  }
}
