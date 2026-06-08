export class RepositoryPathHelper {
  static repositoryPath(owner: string, name: string): string {
    return '/repos/' + encodeURIComponent(owner) + '/' + encodeURIComponent(name);
  }

  static encodeFilePath(filePath: string): string {
    if (filePath.length === 0) {
      return '';
    }

    return filePath.split('/').map((item: string) => encodeURIComponent(item)).join('/');
  }

  static contentsPath(owner: string, name: string, filePath: string): string {
    const encodedPath = RepositoryPathHelper.encodeFilePath(filePath);
    return RepositoryPathHelper.repositoryPath(owner, name) + '/contents' + (encodedPath.length > 0 ? '/' + encodedPath : '');
  }

  static readmePath(owner: string, name: string): string {
    return RepositoryPathHelper.repositoryPath(owner, name) + '/readme';
  }
}
