import { RepositoryFileDto } from '../dto/RepositoryFileDto';
import { RepositoryFileModel } from '../model/RepositoryFileModel';

export class RepositoryFileMapper {
  static fromDto(dto: RepositoryFileDto): RepositoryFileModel {
    return new RepositoryFileModel(dto.name || '', dto.path || dto.name || '', dto.type || '', dto.size || 0);
  }

  static fromDtoList(list: RepositoryFileDto[]): RepositoryFileModel[] {
    return list.map((item: RepositoryFileDto) => RepositoryFileMapper.fromDto(item));
  }
}
