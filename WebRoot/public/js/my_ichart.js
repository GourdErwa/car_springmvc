

function show(data, title) {

    layer.msg('生成统计图中...', 1, -1);

    var chart = new iChart.Column3D({
        render: 'canvasDiv',
        data: data,
        title: {
            text: title,
            color: '#3e576f'
        },
        width: 1150,
        height: 470,
        padding: 20,
        shadow: true,
        shadow_color: '#080808',
        background_color: '#eceeef',
        sub_option: {
            label: {
                color: '#2c2e2a',
                padding: 10
            }
        },
        coordinate: {
            left_board: false,
            scale: [
                {
                    position: 'left',
                    start_scale: 0,
                    end_scale: 50000,
                    scale_space: 5000,
                    listeners: {
                        parseText: function (t, x, y) {
                            return {text: t + "￥  "}
                        }
                    }
                }
            ]
        },
        legend: {
            background_color: iChart.toRgba('#213e49', 0.6),
            border: {radius: 5},
            enable: true,
            align: 'right',
            valign: 'top',
            row: 'max',
            color: '#fefefe',
            column: 1,
            line_height: 15
        },
        tip: {
            enable: true
        }
    });
    chart.draw();
}
