@Component
export struct FeatureText {
  text: string = '';

  build() {
    Row() {
      Text('-')
        .fontSize(18)
        .margin({ right: 8 })

      Text(this.text)
        .fontSize(15)
    }
    .width('100%')
    .margin({ top: 8 })
  }
}
