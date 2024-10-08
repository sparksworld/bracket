## Bracket

一款基于 Flutter 的免费观影 App

> A video App based on Flutter

<img style="margin-right: 10px" src="https://img.shields.io/badge/dart-v3.3.4%20(stable)-blue"> <img style="margin-right: 10px"  src="https://img.shields.io/badge/flutter-v3.19.6-red"> <img 
style="margin-right: 10px" src="https://img.shields.io/badge/fvm-v3.1.7-yellow">

## Film data source

本项目通过[GoFilm](https://github.com/ProudMuBai/GoFilm)接入数据，如有条件可自行部署云端服务(项目中含有多种部署方案)

[网页版观影地址](https://film.fe-spark.cn/)

## Getting Started

```
flutter run
```

## Build

IOS(无企业签名，请自行签名)

```
flutter build ipa
```

ADNDROID

```
flutter build apk
```

## Preview

<table>
  <tr>
      <td>
         <img width="250px" src="./preview/推荐.png">
      </td>
      <td>
         <img width="250px" src="./preview/分类.png">
      </td>
      <td>
         <img width="250px" src="./preview/我的.png">
      </td>
      <td>
         <img width="250px" src="./preview/筛选.png">
      </td>
      <td>
         <img width="250px" src="./preview/播放页.png">
      </td>
   </tr>
</table>

## Matters needing attention

关于影视源问题

> 提供官方免费源`https://film.fe-spark.cn/api/`(末尾一定要带`/`),因为服务器带宽较低，经常访问失败，还请谅解，如有条件，请自行部署好自己的[GoFilm](https://github.com/ProudMuBai/GoFilm)。

## Write at the end

> 免责声明：数据来源均来自于网络，暂不提供下载功能，本项目仅供学习交流，如有侵权，可通过邮箱联系我
