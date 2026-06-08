import { AppRoute } from '../../navigation/AppRoute';
import { LoginStore } from '../../store/LoginStore';

@Component
export struct LoginPage {
  onNavigate: (route: string) => void = () => {};
  private loginStore: LoginStore = new LoginStore();
  @State tokenValue: string = '';
  @State errorMessage: string = '';

  build() {
    Column() {
      Row() {
        Text('Back')
          .fontSize(18)
          .onClick(() => {
            this.onNavigate(AppRoute.WELCOME)
          })

        Text('Token 登录')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 16 })

        Blank()
      }
      .width('100%')
      .height(56)
      .padding({ left: 20, right: 20 })

      Column() {
        Text('第一阶段先使用 Token 登录')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)

        Text('当前版本先完成本地状态流转，下一步接入真实用户接口验证。')
          .fontSize(15)
          .lineHeight(24)
          .margin({ top: 12 })

        TextInput({ placeholder: '请输入 AtomGit Token', text: this.tokenValue })
          .height(48)
          .fontSize(15)
          .backgroundColor('#F3F4F6')
          .borderRadius(12)
          .margin({ top: 28 })
          .onChange((value: string) => {
            this.tokenValue = value;
            this.loginStore.setToken(value);
            this.errorMessage = '';
          })

        if (this.errorMessage.length > 0) {
          Text(this.errorMessage)
            .fontSize(13)
            .fontColor('#E5484D')
            .margin({ top: 8 })
        }

        Button('登录并进入首页')
          .width('100%')
          .height(48)
          .fontSize(16)
          .margin({ top: 20 })
          .onClick(() => {
            const success = this.loginStore.loginWithToken();
            if (success) {
              this.onNavigate(AppRoute.HOME)
            } else {
              this.errorMessage = this.loginStore.errorMessage;
            }
          })
      }
      .width('90%')
      .padding(22)
      .margin({ top: 40 })
      .backgroundColor(Color.White)
      .borderRadius(20)

      Blank()
    }
    .width('100%')
    .height('100%')
  }
}
