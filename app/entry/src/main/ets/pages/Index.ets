@Entry
@Component
struct Index {
  @State currentRoute: string = 'welcome';

  build() {
    Column() {
      if (this.currentRoute === 'welcome') {
        this.WelcomePage()
      } else if (this.currentRoute === 'login') {
        this.LoginPage()
      } else if (this.currentRoute === 'home') {
        this.MainLayout('home')
      } else if (this.currentRoute === 'search') {
        this.MainLayout('search')
      } else if (this.currentRoute === 'mine') {
        this.MainLayout('mine')
      } else if (this.currentRoute === 'repoDetail') {
        this.RepoDetailPage()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F8FA')
  }

  @Builder
  WelcomePage() {
    Column() {
      Blank()

      Text('OpenAtomGit')
        .fontSize(34)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111827')

      Text('从 0 构建 AtomGit HarmonyOS 客户端')
        .fontSize(16)
        .fontColor('#6B7280')
        .margin({ top: 12 })

      Column() {
        Text('项目目标')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .margin({ bottom: 16 })

        this.FeatureText('Token 登录与登录态恢复')
        this.FeatureText('仓库、用户、Issue 搜索')
        this.FeatureText('仓库详情与代码浏览')
        this.FeatureText('Issue 列表与详情')
        this.FeatureText('本地缓存与浏览历史')
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
        .fontWeight(FontWeight.Bold)
        .margin({ top: 32 })
        .onClick(() => {
          this.currentRoute = 'login'
        })

      Button('先进入首页预览')
        .width('88%')
        .height(48)
        .fontSize(16)
        .fontColor('#0A59F7')
        .backgroundColor('#EAF1FF')
        .margin({ top: 12 })
        .onClick(() => {
          this.currentRoute = 'home'
        })

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding({ left: 20, right: 20 })
  }

  @Builder
  LoginPage() {
    Column() {
      Row() {
        Text('←')
          .fontSize(26)
          .fontColor('#111827')
          .onClick(() => {
            this.currentRoute = 'welcome'
          })

        Text('Token 登录')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
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
          .fontColor('#111827')

        Text('后续会接入 AtomGit /api/v5/user 验证 Token，并保存登录态。')
          .fontSize(15)
          .fontColor('#6B7280')
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
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20 })
          .onClick(() => {
            this.currentRoute = 'home'
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

  @Builder
  MainLayout(active: string) {
    Column() {
      if (active === 'home') {
        this.HomePage()
      } else if (active === 'search') {
        this.SearchPage()
      } else {
        this.MinePage()
      }

      this.BottomTabs()
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  HomePage() {
    Column() {
      this.PageHeader('首页', '聚合我的仓库、最近访问和待处理 Issue')

      Scroll() {
        Column() {
          this.StatCard('我的仓库', '12', '后续接入 /api/v5/user/repos')
          this.StatCard('我的 Issue', '3', '后续接入 Issue 列表接口')
          this.StatCard('最近访问', 'OpenAtomGit', '本地浏览历史会记录最近打开的仓库')

          Button('打开仓库详情示例')
            .width('100%')
            .height(48)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 12, bottom: 24 })
            .onClick(() => {
              this.currentRoute = 'repoDetail'
            })
        }
        .padding({ left: 20, right: 20 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  SearchPage() {
    Column() {
      this.PageHeader('搜索', '支持仓库、用户和 Issue 搜索')

      Column() {
        TextInput({ placeholder: '搜索 AtomGit 仓库、用户或 Issue' })
          .height(48)
          .fontSize(15)
          .backgroundColor('#F3F4F6')
          .borderRadius(12)

        Row() {
          this.SearchTypeChip('仓库')
          this.SearchTypeChip('用户')
          this.SearchTypeChip('Issue')
        }
        .margin({ top: 16 })

        this.EmptyState('搜索能力将在 V0.3 接入 AtomGit Search API')
      }
      .width('90%')
      .padding(20)
      .backgroundColor(Color.White)
      .borderRadius(20)
      .margin({ top: 20 })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  MinePage() {
    Column() {
      this.PageHeader('我的', '登录信息、Token 管理和本地设置')

      Column() {
        Text('未登录用户')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')

        Text('当前是页面骨架阶段，下一步会接入 TokenStorage 和 /api/v5/user。')
          .fontSize(15)
          .fontColor('#6B7280')
          .lineHeight(24)
          .margin({ top: 12 })

        Button('回到登录页')
          .width('100%')
          .height(48)
          .fontSize(16)
          .margin({ top: 24 })
          .onClick(() => {
            this.currentRoute = 'login'
          })
      }
      .width('90%')
      .padding(22)
      .backgroundColor(Color.White)
      .borderRadius(20)
      .margin({ top: 20 })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  RepoDetailPage() {
    Column() {
      Row() {
        Text('←')
          .fontSize(26)
          .fontColor('#111827')
          .onClick(() => {
            this.currentRoute = 'home'
          })

        Text('仓库详情')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .margin({ left: 16 })

        Blank()
      }
      .width('100%')
      .height(56)
      .padding({ left: 20, right: 20 })

      Column() {
        Text('hu-qi/OpenAtomGit')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')

        Text('一个从 0 构建的 HarmonyOS AtomGit 客户端实践项目。')
          .fontSize(15)
          .fontColor('#6B7280')
          .lineHeight(24)
          .margin({ top: 12 })

        Row() {
          this.RepoMeta('ArkTS')
          this.RepoMeta('Star 0')
          this.RepoMeta('Issue 0')
        }
        .margin({ top: 18 })

        Divider()
          .margin({ top: 20, bottom: 20 })

        this.FeatureText('概览：仓库基础信息')
        this.FeatureText('代码：文件树与文件内容预览')
        this.FeatureText('Issue：列表、详情和评论展示')
        this.FeatureText('README：Markdown 渲染')
      }
      .width('90%')
      .padding(22)
      .backgroundColor(Color.White)
      .borderRadius(20)
      .margin({ top: 20 })

      Blank()
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  BottomTabs() {
    Row() {
      this.TabItem('首页', 'home')
      this.TabItem('搜索', 'search')
      this.TabItem('我的', 'mine')
    }
    .width('100%')
    .height(64)
    .backgroundColor(Color.White)
    .borderWidth({ top: 1 })
    .borderColor('#E5E7EB')
  }

  @Builder
  TabItem(title: string, route: string) {
    Column() {
      Text(title)
        .fontSize(15)
        .fontWeight(this.currentRoute === route ? FontWeight.Bold : FontWeight.Normal)
        .fontColor(this.currentRoute === route ? '#0A59F7' : '#6B7280')
    }
    .layoutWeight(1)
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentRoute = route
    })
  }

  @Builder
  PageHeader(title: string, desc: string) {
    Column() {
      Text(title)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111827')

      Text(desc)
        .fontSize(14)
        .fontColor('#6B7280')
        .margin({ top: 8 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding({ left: 20, right: 20, top: 24, bottom: 12 })
  }

  @Builder
  StatCard(title: string, value: string, desc: string) {
    Column() {
      Text(title)
        .fontSize(16)
        .fontColor('#6B7280')

      Text(value)
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111827')
        .margin({ top: 8 })

      Text(desc)
        .fontSize(14)
        .fontColor('#6B7280')
        .lineHeight(22)
        .margin({ top: 8 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(18)
    .margin({ bottom: 14 })
  }

  @Builder
  FeatureText(text: string) {
    Row() {
      Text('•')
        .fontSize(18)
        .fontColor('#0A59F7')
        .margin({ right: 8 })

      Text(text)
        .fontSize(15)
        .fontColor('#374151')
    }
    .width('100%')
    .margin({ top: 8 })
  }

  @Builder
  SearchTypeChip(text: string) {
    Text(text)
      .fontSize(14)
      .fontColor('#0A59F7')
      .padding({ left: 14, right: 14, top: 8, bottom: 8 })
      .backgroundColor('#EAF1FF')
      .borderRadius(16)
      .margin({ right: 10 })
  }

  @Builder
  EmptyState(text: string) {
    Column() {
      Text('暂无数据')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111827')

      Text(text)
        .fontSize(14)
        .fontColor('#6B7280')
        .lineHeight(22)
        .textAlign(TextAlign.Center)
        .margin({ top: 10 })
    }
    .width('100%')
    .padding(32)
    .margin({ top: 20 })
    .backgroundColor('#F9FAFB')
    .borderRadius(16)
  }

  @Builder
  RepoMeta(text: string) {
    Text(text)
      .fontSize(13)
      .fontColor('#374151')
      .padding({ left: 10, right: 10, top: 6, bottom: 6 })
      .backgroundColor('#F3F4F6')
      .borderRadius(12)
      .margin({ right: 8 })
  }
}
