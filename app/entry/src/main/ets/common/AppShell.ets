import { AppRoute } from '../navigation/AppRoute';
import { WelcomePage } from '../pages/welcome/WelcomePage';
import { LoginPage } from '../pages/login/LoginPage';
import { MainPage } from '../pages/main/MainPage';
import { SearchPage } from '../pages/search/SearchPage';
import { AccountPage } from '../pages/account/AccountPage';
import { RepositoryDetailPage } from '../pages/repository/RepositoryDetailPage';

@Component
export struct AppShell {
  @State currentRoute: string = AppRoute.WELCOME;

  build() {
    Column() {
      if (this.currentRoute === AppRoute.WELCOME) {
        WelcomePage({ onNavigate: (route: string) => { this.currentRoute = route } })
      } else if (this.currentRoute === AppRoute.LOGIN) {
        LoginPage({ onNavigate: (route: string) => { this.currentRoute = route } })
      } else if (this.currentRoute === AppRoute.HOME) {
        this.MainLayout(AppRoute.HOME)
      } else if (this.currentRoute === AppRoute.SEARCH) {
        this.MainLayout(AppRoute.SEARCH)
      } else if (this.currentRoute === AppRoute.MINE) {
        this.MainLayout(AppRoute.MINE)
      } else if (this.currentRoute === AppRoute.REPOSITORY_DETAIL) {
        RepositoryDetailPage({ onNavigate: (route: string) => { this.currentRoute = route } })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F8FA')
  }

  @Builder
  MainLayout(activeRoute: string) {
    Column() {
      if (activeRoute === AppRoute.HOME) {
        MainPage({ onNavigate: (route: string) => { this.currentRoute = route } })
      } else if (activeRoute === AppRoute.SEARCH) {
        SearchPage({ onNavigate: (route: string) => { this.currentRoute = route } })
      } else {
        AccountPage({ onNavigate: (route: string) => { this.currentRoute = route } })
      }

      this.BottomTabs(activeRoute)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  BottomTabs(activeRoute: string) {
    Row() {
      this.TabItem('Home', AppRoute.HOME, activeRoute)
      this.TabItem('Search', AppRoute.SEARCH, activeRoute)
      this.TabItem('Account', AppRoute.MINE, activeRoute)
    }
    .width('100%')
    .height(64)
    .backgroundColor(Color.White)
  }

  @Builder
  TabItem(title: string, route: string, activeRoute: string) {
    Column() {
      Text(title)
        .fontSize(15)
        .fontWeight(activeRoute === route ? FontWeight.Bold : FontWeight.Normal)
    }
    .layoutWeight(1)
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentRoute = route
    })
  }
}
