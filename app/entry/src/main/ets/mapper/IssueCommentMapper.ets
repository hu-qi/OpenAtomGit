import { IssueCommentDto } from '../dto/IssueCommentDto';
import { IssueCommentModel } from '../model/IssueCommentModel';

export class IssueCommentMapper {
  static fromDto(dto: IssueCommentDto): IssueCommentModel {
    const author = dto.user?.login || dto.user?.name || '';
    return new IssueCommentModel(dto.id || 0, dto.body || '', author, dto.created_at || '', dto.updated_at || '');
  }

  static fromDtoList(list: IssueCommentDto[]): IssueCommentModel[] {
    return list.map((item: IssueCommentDto) => IssueCommentMapper.fromDto(item));
  }
}
