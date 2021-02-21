var host = process.env.SPARK_HOME;
if (typeof host === 'undefined') {
    console.log(666);
} else {
    console.log('ok');
}
