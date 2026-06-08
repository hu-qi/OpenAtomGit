import { RepositoryModel } from '../model/RepositoryModel';

export class RepositoryStore {
  private static selectedRepository: RepositoryModel | null = null;

  static setSelectedRepository(repository: RepositoryModel): void {
    RepositoryStore.selectedRepository = repository;
  }

  static getSelectedRepository(): RepositoryModel | null {
    return RepositoryStore.selectedRepository;
  }

  static clearSelectedRepository(): void {
    RepositoryStore.selectedRepository = null;
  }
}
