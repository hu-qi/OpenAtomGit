import { AppRoute } from '../../navigation/AppRoute';
import { FeatureText } from '../../common/FeatureText';

@Component
export struct WelcomePage {
  onNavigate: (route: string) => void = () => {};

  build() {
    Column() {
      Blank()

      Text('OpenAtomGit')
        .fontSize(34)
        .fontWeight(FontWeight.Bold)

      Text('从 0 构建 AtomGit HarmonyOS 客户端')
        .fontSize(16)
        .margin({ top: 12 })

      Column() {
        Text('项目目标')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 16 })

        FeatureText({ text: 'Token 登录与登录态恢复' })
        FeatureText({ text: '仓库、用户、Issue 搜索' })
        FeatureText({ text: '仓库详情与代码浏览' })
        FeatureText({ text: 'Issue 列表与详情' })
        FeatureText({ text: '本地缓存与浏览历史' })
      }
      .width('88%')
      .padding(20)
      .margin({ top: 40 })
      .backgroundColor(Color.White)
      .borderRadius(20)

      Button('开始体验')
        .width('88%')
        .height(48)
        .fontSize(16)
        .margin({ top: 32 })
        .onClick(() => {
          this.onNavigate(AppRoute.LOGIN)
        })

      Button('先进入首页预览')
        .width('88%')
        .height(48)
        .fontSize(16)
        .margin({ top: 12 })
        .onClick(() => {
          this.onNavigate(AppRoute.HOME)
        })

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding({ left: 20, right: 20 })
  }
}
