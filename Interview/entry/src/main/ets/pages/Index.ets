import mediaquery from '@ohos.mediaquery'
import { Auth } from '../common/utils/Auth'
import { vp2vp } from '../common/utils/Basic'
import { Logger } from '../common/utils/Logger'
import { Home } from '../views/Index/Home'
import { Interview } from '../views/Index/Interview'
import { Mine } from '../views/Index/Mine'
import { Project } from '../views/Index/Project'

Auth.initLocalUser()

class ToolBarItem {
  defaultIcon: string | Resource
  activeIcon: string | Resource
  label: string

  constructor(defaultIcon: string | Resource, activeIcon: string | Resource, label: string) {
    this.defaultIcon = defaultIcon
    this.activeIcon = activeIcon
    this.label = label
  }
}

@Entry
@Component
struct Index {
  @State
  activeIndex: number = 0
  toolBars: ToolBarItem[] = [
    new ToolBarItem($r('app.media.home'),$r('app.media.home_select'), '首页' ),
    new ToolBarItem($r('app.media.project'),$r('app.media.project_select'), '项目' ),
    new ToolBarItem($r('app.media.interview'),$r('app.media.interview_select'), '面经' ),
    new ToolBarItem($r('app.media.mine'),$r('app.media.mine_select'), '我的' )
  ]
  @State
  isLandscape: boolean = false
  listenerScreen = mediaquery.matchMediaSync('(orientation: landscape) and (device-type: tablet)')

  aboutToAppear() {
    this.listenerScreen.on('change', (result) => {
      this.isLandscape = result.matches
    })
    Logger.info(`AAAAA => ${this.toolBars.length}`)
  }

  @Builder
  TabBarBuilder(item: ToolBarItem, index: number) {
    Column() {
      Image(this.activeIndex === index ? item.activeIcon : item.defaultIcon)
        .width(vp2vp(24))
      Text(item.label)
        .fontSize(vp2vp(12))
        .margin({ top: vp2vp(4) })
        .fontColor(this.activeIndex === index ? '#000' : '#aaa')
    }
  }

  build() {
    Tabs({
      index: this.activeIndex
    }) {
      ForEach(this.toolBars, (item: ToolBarItem, index: number) => {
        TabContent() {
          if (index ===0) Home()
          else if (index === 1) Project()
          else if (index === 2) Interview()
          else Mine()
        }
        .tabBar(this.TabBarBuilder(item, index))
      })
    }
    .vertical(this.isLandscape)
    .barPosition(this.isLandscape ? BarPosition.Start : BarPosition.End)
    .barHeight(this.isLandscape ? vp2vp(400) : vp2vp(50))
    .onChange(index => this.activeIndex = index)
  }
}