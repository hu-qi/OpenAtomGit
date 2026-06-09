import { RepositoryDetailConstants } from './RepositoryDetailConstants';

export class RepositoryContentPreviewHelper {
  static truncateReadmeContent(content: string): string {
    return RepositoryContentPreviewHelper.truncateContent(content, RepositoryDetailConstants.README_PREVIEW_MAX_LENGTH);
  }

  static truncateFileContent(content: string): string {
    return RepositoryContentPreviewHelper.truncateContent(content, RepositoryDetailConstants.FILE_PREVIEW_MAX_LENGTH);
  }

  private static truncateContent(content: string, maxLength: number): string {
    if (content.length <= maxLength) {
      return content;
    }

    return content.substring(0, maxLength) + '\n...';
  }
}
