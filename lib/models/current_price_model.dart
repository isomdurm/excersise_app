class CurrentPrice {
  var time;
  var disclaimer;
  var chartName;
  var bpi;

  CurrentPrice({this.time, this.disclaimer, this.chartName, this.bpi});

  CurrentPrice.fromJson(Map<String, dynamic> json) {
    time = json['time'].cast();
    disclaimer = json['disclaimer'];
    chartName = json['chartName'];
    bpi = json['bpi'].cast();
  }
}