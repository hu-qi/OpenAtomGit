import { AppRoute } from '../../navigation/AppRoute';

@Component
export struct LoginPage {
  onNavigate: (route: string) => void = () => {};

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

        Text('后续会接入用户接口验证 Token，并保存登录态。')
          .fontSize(15)
          .lineHeight(24)
          .margin({ top: 12 })

        TextInput({ placeholder: '请输入 AtomGit Token' })
          .height(48)
          .fontSize(15)
          .backgroundColor('#F3F4F6')
          .borderRadius(12)
          .margin({ top: 28 })

        Button('登录并进入首页')
          .width('100%')
          .height(48)
          .fontSize(16)
          .margin({ top: 20 })
          .onClick(() => {
            this.onNavigate(AppRoute.HOME)
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
