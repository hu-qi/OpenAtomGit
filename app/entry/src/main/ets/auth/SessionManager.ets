import { UserModel } from '../model/UserModel';

export class SessionManager {
  private static currentUser: UserModel | null = null;

  static setCurrentUser(user: UserModel): void {
    SessionManager.currentUser = user;
  }

  static getCurrentUser(): UserModel | null {
    return SessionManager.currentUser;
  }

  static clear(): void {
    SessionManager.currentUser = null;
  }
}
