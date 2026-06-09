@Component
export struct RepositoryBackAction {
  onBack: () => void = () => {};

  build() {
    Text('Back')
      .fontSize(18)
      .onClick(() => {
        this.onBack();
      })
  }
}
