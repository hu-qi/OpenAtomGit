@Component
export struct PageHeader {
  title: string = '';
  desc: string = '';

  build() {
    Column() {
      Text(this.title)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)

      Text(this.desc)
        .fontSize(14)
        .margin({ top: 8 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding({ left: 20, right: 20, top: 24, bottom: 12 })
  }
}
