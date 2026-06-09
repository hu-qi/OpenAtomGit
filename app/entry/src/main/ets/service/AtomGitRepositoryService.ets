import { TokenManager } from '../auth/TokenManager';
import { RepositoryDto } from '../dto/RepositoryDto';
import { RepositoryFileContentDto } from '../dto/RepositoryFileContentDto';
import { RepositoryFileDto } from '../dto/RepositoryFileDto';
import { RepositoryReadmeDto } from '../dto/RepositoryReadmeDto';
import { RepositoryFileModel } from '../model/RepositoryFileModel';
import { RepositoryModel } from '../model/RepositoryModel';
import { AtomGitHttpClient } from './AtomGitHttpClient';
import { JsonParseHelper } from './JsonParseHelper';
import { RepositoryPathHelper } from './RepositoryPathHelper';
import { RepositoryRequestGuard } from './RepositoryRequestGuard';
import { RepositoryResponseMapper } from './RepositoryResponseMapper';

export class AtomGitRepositoryService {
  static async getRepositoryDetail(repository: RepositoryModel): Promise<RepositoryModel | null> {
    const token = TokenManager.getToken();
    if (!RepositoryRequestGuard.canRequestRepository(token, repository)) {
      return null;
    }

    const path = RepositoryPathHelper.repositoryPath(repository.owner, repository.name);
    const body = await AtomGitHttpClient.get(path, token);
    const dto = JsonParseHelper.parseObject<RepositoryDto>(body);
    return RepositoryResponseMapper.repositoryFromDto(dto);
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

    const parsed = JsonParseHelper.parseObject<RepositoryReadmeDto>(body);
    return RepositoryResponseMapper.readmeContentFromDto(parsed, body);
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
    const list = JsonParseHelper.parseArray<RepositoryFileDto>(body);
    return RepositoryResponseMapper.filesFromDtoList(list);
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

    const parsed = JsonParseHelper.parseObject<RepositoryFileContentDto>(body);
    return RepositoryResponseMapper.fileContentFromDto(parsed, body);
  }
}
