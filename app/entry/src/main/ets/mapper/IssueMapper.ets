import { IssueDto } from '../dto/IssueDto';
import { IssueModel } from '../model/IssueModel';

export class IssueMapper {
  static fromDto(dto: IssueDto): IssueModel {
    let author = '';
    if (dto.user !== undefined) {
      author = dto.user.login || dto.user.name || '';
    }

    return new IssueModel(
      dto.number || 0,
      dto.title || '',
      dto.state || '',
      author,
      dto.created_at || '',
      dto.updated_at || '',
      dto.body || '',
      dto.comments || 0
    );
  }

  static fromDtoList(list: IssueDto[]): IssueModel[] {
    return list.map((item: IssueDto) => IssueMapper.fromDto(item));
  }
}
