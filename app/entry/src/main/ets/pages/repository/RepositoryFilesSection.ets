import { RepositoryFileModel } from '../../model/RepositoryFileModel';

@Component
export struct RepositoryFilesSection {
  currentPath: string = '';
  files: RepositoryFileModel[] = [];
  isFilesLoading: boolean = false;
  filesMessage: string = '';
  selectedFilePath: string = '';
  isFileContentLoading: boolean = false;
  fileContentMessage: string = '';
  fileContent: string = '';
  onOpenDirectory: (path: string) => void = () => {};
  onOpenFile: (path: string) => void = () => {};
  onUp: () => void = () => {};

  build() {
    Column() {
      Text('Files')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 28 })

      Row() {
        Text(this.currentPath.length === 0 ? 'Path: /' : 'Path: /' + this.currentPath)
          .fontSize(13)
          .layoutWeight(1)

        if (this.currentPath.length > 0) {
          Text('Up')
            .fontSize(13)
            .fontWeight(FontWeight.Bold)
            .onClick(() => {
              this.onUp();
            })
        }
      }
      .width('100%')
      .margin({ top: 8 })

      if (this.isFilesLoading) {
        Text('Loading files...')
          .fontSize(15)
          .margin({ top: 12 })
      }

      if (this.filesMessage.length > 0) {
        Text(this.filesMessage)
          .fontSize(14)
          .fontColor('#6B7280')
          .margin({ top: 12 })
      }

      ForEach(this.files, (item: RepositoryFileModel) => {
        Row() {
          Text(item.isDirectory() ? 'DIR' : 'FILE')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .width(44)

          Column() {
            Text(item.name)
              .fontSize(15)
              .fontWeight(FontWeight.Bold)
            Text(item.path)
              .fontSize(12)
              .margin({ top: 4 })
          }
          .layoutWeight(1)

          Text(item.isDirectory() ? 'Open' : 'Preview')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .padding(12)
        .margin({ top: 8 })
        .backgroundColor(Color.White)
        .borderRadius(12)
        .onClick(() => {
          if (item.isDirectory()) {
            this.onOpenDirectory(item.path);
          } else {
            this.onOpenFile(item.path);
          }
        })
      }, (item: RepositoryFileModel) => item.path)

      if (this.selectedFilePath.length > 0) {
        Text('File Preview')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 28 })

        Text(this.selectedFilePath)
          .fontSize(13)
          .margin({ top: 8 })

        if (this.isFileContentLoading) {
          Text('Loading file content...')
            .fontSize(15)
            .margin({ top: 12 })
        }

        if (this.fileContentMessage.length > 0) {
          Text(this.fileContentMessage)
            .fontSize(14)
            .fontColor('#6B7280')
            .margin({ top: 12 })
        }

        if (this.fileContent.length > 0) {
          Text(this.fileContent)
            .fontSize(12)
            .lineHeight(18)
            .padding(12)
            .margin({ top: 12 })
            .backgroundColor(Color.White)
            .borderRadius(12)
        }
      }
    }
    .width('100%')
  }
}
