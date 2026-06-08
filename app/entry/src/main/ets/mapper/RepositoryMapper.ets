import { RepositoryDto } from '../dto/RepositoryDto';
import { RepositoryModel } from '../model/RepositoryModel';

export class RepositoryMapper {
  static fromDto(dto: RepositoryDto): RepositoryModel {
    const fullName = dto.full_name || dto.path || dto.name || '';
    const parts = fullName.split('/');
    const owner = parts.length > 1 ? parts[0] : (dto.namespace || '');
    const name = parts.length > 1 ? parts[1] : fullName;
    return new RepositoryModel(owner, name, dto.description || '');
  }

  static fromDtoList(list: RepositoryDto[]): RepositoryModel[] {
    return list.map((item: RepositoryDto) => RepositoryMapper.fromDto(item));
  }
}
