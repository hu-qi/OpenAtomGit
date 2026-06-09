import { RepositoryDto } from '../dto/RepositoryDto';
import { RepositoryFileContentDto } from '../dto/RepositoryFileContentDto';
import { RepositoryFileDto } from '../dto/RepositoryFileDto';
import { RepositoryReadmeDto } from '../dto/RepositoryReadmeDto';
import { RepositoryFileMapper } from '../mapper/RepositoryFileMapper';
import { RepositoryMapper } from '../mapper/RepositoryMapper';
import { RepositoryFileModel } from '../model/RepositoryFileModel';
import { RepositoryModel } from '../model/RepositoryModel';

export class RepositoryResponseMapper {
  static repositoryFromDto(dto: RepositoryDto | null): RepositoryModel | null {
    if (dto === null) {
      return null;
    }

    return RepositoryMapper.fromDto(dto);
  }

  static filesFromDtoList(list: RepositoryFileDto[]): RepositoryFileModel[] {
    return RepositoryFileMapper.fromDtoList(list);
  }

  static readmeContentFromDto(dto: RepositoryReadmeDto | null, fallback: string): string {
    if (dto === null) {
      return fallback;
    }

    return dto.content || dto.html || dto.text || fallback;
  }

  static fileContentFromDto(dto: RepositoryFileContentDto | null, fallback: string): string {
    if (dto === null) {
      return fallback;
    }

    return dto.content || fallback;
  }
}
