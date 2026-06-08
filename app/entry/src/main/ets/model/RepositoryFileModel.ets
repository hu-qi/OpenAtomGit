export class RepositoryFileModel {
  name: string = '';
  path: string = '';
  type: string = '';
  size: number = 0;

  constructor(name: string, path: string, type: string, size: number = 0) {
    this.name = name;
    this.path = path;
    this.type = type;
    this.size = size;
  }

  isDirectory(): boolean {
    return this.type === 'dir' || this.type === 'tree';
  }
}
