import { AppRoute } from '../../navigation/AppRoute';
import { TokenManager } from '../../auth/TokenManager';
import { SessionManager } from '../../auth/SessionManager';
import { UserModel } from '../../model/UserModel';

@Component
export struct AccountPage {
  onNavigate: (route: string) => void = () => {};
  @State tokenPreview: string = TokenManager.getToken();
  private currentUser: UserModel | null = SessionManager.getCurrentUser();

  build() {
    Column() {
      Text('Account')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)

      Text(this.currentUser === null ? 'No user' : this.currentUser.nickname)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 16 })

      Text(this.currentUser === null ? '' : this.currentUser.username)
        .fontSize(16)
        .margin({ top: 8 })

      Text(this.tokenPreview.length > 0 ? 'Token saved locally' : 'No token')
        .fontSize(16)
        .margin({ top: 16 })

      Button('Logout')
        .width('90%')
        .height(48)
        .margin({ top: 24 })
        .onClick(() => {
          TokenManager.clear();
          SessionManager.clear();
          this.tokenPreview = '';
          this.onNavigate(AppRoute.LOGIN);
        })
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }
}
