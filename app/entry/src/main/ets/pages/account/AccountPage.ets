import { AppRoute } from '../../navigation/AppRoute';
import { TokenManager } from '../../auth/TokenManager';

@Component
export struct AccountPage {
  onNavigate: (route: string) => void = () => {};
  @State tokenPreview: string = TokenManager.getToken();

  build() {
    Column() {
      Text('Account')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)

      Text(this.tokenPreview.length > 0 ? 'Token saved locally' : 'No token')
        .fontSize(16)
        .margin({ top: 16 })

      Button('Logout')
        .width('90%')
        .height(48)
        .margin({ top: 24 })
        .onClick(() => {
          TokenManager.clear();
          this.tokenPreview = '';
          this.onNavigate(AppRoute.LOGIN);
        })
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }
}
