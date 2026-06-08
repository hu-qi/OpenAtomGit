import { RepositoryDto } from '../dto/RepositoryDto';
import { RepositoryModel } from '../model/RepositoryModel';

export class RepositoryMapper {
  static fromDto(dto: RepositoryDto): RepositoryModel {
    const fullName = dto.full_name || dto.path || dto.name || '';
    const parts = fullName.split('/');
    const owner = parts.length > 1 ? parts[0] : (dto.namespace || '');
    const name = parts.length > 1 ? parts[1] : fullName;
    const stars = dto.stargazers_count || dto.stars_count || 0;
    const forks = dto.forks_count || 0;
    const watchers = dto.watchers_count || 0;
    const defaultBranch = dto.default_branch || '';
    return new RepositoryModel(owner, name, dto.description || '', stars, forks, watchers, defaultBranch);
  }

  static fromDtoList(list: RepositoryDto[]): RepositoryModel[] {
    return list.map((item: RepositoryDto) => RepositoryMapper.fromDto(item));
  }
}
