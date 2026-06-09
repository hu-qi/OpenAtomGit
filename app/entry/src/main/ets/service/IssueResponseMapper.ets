import { IssueCommentDto } from '../dto/IssueCommentDto';
import { IssueDto } from '../dto/IssueDto';
import { IssueCommentMapper } from '../mapper/IssueCommentMapper';
import { IssueMapper } from '../mapper/IssueMapper';
import { IssueCommentModel } from '../model/IssueCommentModel';
import { IssueModel } from '../model/IssueModel';

export class IssueResponseMapper {
  static issuesFromDtoList(list: IssueDto[]): IssueModel[] {
    return IssueMapper.fromDtoList(list);
  }

  static issueFromDto(dto: IssueDto | null): IssueModel | null {
    if (dto === null) {
      return null;
    }

    return IssueMapper.fromDto(dto);
  }

  static commentsFromDtoList(list: IssueCommentDto[]): IssueCommentModel[] {
    return IssueCommentMapper.fromDtoList(list);
  }
}
